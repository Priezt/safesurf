from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import requests
import yaml
import json
import base64

with open("/setting.yaml", "r") as f:
    setting = yaml.load(f)

# Create your views here.

def open_url(request):
    return render(request, 'jump.html')

@csrf_exempt
def jump_to_guacamole(request):
    if request.method != "POST":
        return JsonResponse({
            "success": False,
            "msg": "method not supported",
        })
    url = request.POST.get("url")
    width = request.POST.get("width")
    height = request.POST.get("height")
    #height = int((float(height) / float(width)) * 1280)
    #width = 1280
    response = requests.post("http://operator:%s/open" % (setting["operator"]["port"]), {
        "url": url,
        "width": width,
        "height": height,
    })
    result = json.loads(str(response.text))
    client_name = base64.b64encode((result["container_name"] + '\0' + 'c' + '\0' + 'noauth').encode()).decode()
    return JsonResponse({
        "success": True,
        "url": "/safesurf/#/client/%s" % client_name,
    })
