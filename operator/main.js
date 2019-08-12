const Koa = require('koa');
const Router = require('koa-router');
const bodyParser = require('koa-bodyparser');
const yaml = require('js-yaml');
const fs = require('fs');
const shell = require('shelljs');
let setting = yaml.safeLoad(fs.readFileSync("/setting.yaml", 'utf8'));

const web_server = new Koa();
const router = new Router();

var containers = {
	all: [],
	free: [],
	running: new Set(),
	start_time: {},
};

for(let c=1;c<=setting.containers.count;c++){
	containers.all.push(`ss-chrome-${c}`);
	containers.free.push(`ss-chrome-${c}`);
}

async function get_container(){
	let c = containers.free.shift();
	containers.running.add(c);
	containers.start_time[c] = Date.now();
	return c;
}

router.post('/open', async (ctx, next) => {
	let url = ctx.request.body.url;
	let width = ctx.request.body.width;
	let height = ctx.request.body.height;
	let cn = await get_container();
	console.log(`${cn}: <${width},${height}>:${url}`);
	await new Promise((resolve)=>{
		shell.exec(`docker run -d --rm --name ${cn} -e WINDOW_WIDTH=${width} -e WINDOW_HEIGHT=${height} --network safesurf_safesurf safesurf-browser '${url}'`, (code, stdout, stderr)=>{
			//console.log(code);
			//console.log(stdout);
			resolve(true);
		});
	});
	ctx.body = {
		container_name: cn,
	};
});

async function recycle_container(){
	output = await new Promise((resolve)=>{
		shell.exec("docker ps --filter status=running --format '{{.Names}}'  | grep ^ss-chrome| tr '\\n' ,", (code, stdout, stderr)=>{
			resolve(stdout);
		});
	});
	let running_containers = output.split(',').filter(c=>c.length>0);
	let running_containers_set = new Set(running_containers);
	for(let c of [...containers.running]){
		if(! running_containers_set.has(c)){
			console.log(`recycle ${c}`);
			containers.running.delete(c);
			containers.free.push(c);
		}
	}
	let current_time = Date.now();
	for(let c of running_containers){
		if(current_time - containers.start_time[c] >= setting.containers.timeout * 1000){
			console.log(`stop ${c}`);
			await new Promise((resolve)=>{
				shell.exec(`docker stop ${c}`, ()=>{
					resolve(true);
				});
			});
		}
	}
	setTimeout(recycle_container, 10 * 1000);
}

(async()=>{
	setTimeout(recycle_container, 30 * 1000);
	web_server
		.use(bodyParser())
		.use(router.routes())
		.use(router.allowedMethods());
	web_server.listen(setting.operator.port);
	console.log(`Listening on: 0.0.0.0:${setting.operator.port}`);
})();

