from django.http import HttpResponse

def index(request):
    line1 = '<h1 style="text-align: center">first htmls!</h1>'
    line2 = '<a href="/play/">enter game</a>'
    return HttpResponse(line1 + line2)

def play(request):    
    line1 = '<h1 style="text-align: center">game htmls!</h1>'
    line2 = '<a href="/">return game</a>'
    return HttpResponse(line1 + line2)
    
