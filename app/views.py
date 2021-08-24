from django.views.generic.base import TemplateView


class Welcome(TemplateView):
    """Displays the welcome page"""

    template_name = "welcome.html"
