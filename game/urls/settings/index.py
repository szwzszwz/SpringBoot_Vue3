from django.urls import path
#from django.urls import path, include
from game.views.settings.getinfo import getinfo
from game.views.settings.login import signin
from game.views.settings.logout import signout
from game.views.settings.register import register

urlpatterns = [
	# url名称一般习惯为函数名称，函数名称，起名字一般习惯路径名
	path("getinfo/",getinfo,name="settings_getinfo"),
	path("login/",signin,name="settings_login"),
	path("logout/",signout,name="settings_logout"),
	path("register/",register,name="settings_register"),
]
