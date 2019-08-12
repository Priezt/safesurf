set_property "auth-provider" "net.sourceforge.guacamole.net.auth.noauth.NoAuthenticationProvider"
set_property "noauth-config" "/noauth-config.xml"
ln -s /guacamole-auth-noauth.jar "$GUACAMOLE_EXT"
