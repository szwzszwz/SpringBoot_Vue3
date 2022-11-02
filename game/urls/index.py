import django.urls import path, include

import game.views.index import index
urlpatterns = [
	path("", index, name="index"),
	path("menu/", include("game.urls.menu.index")),
	path("playground/", include("game.urls.playground.index")),
	path("settings/",include("game.urls.settings.index")),
]

