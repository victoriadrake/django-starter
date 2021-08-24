from app.settings.base import *

DEBUG = True

ALLOWED_HOSTS = ["localhost", "127.0.0.1"]

INSTALLED_APPS += (
    # Apps for local development
    "debug_toolbar",
)

MIDDLEWARE = [
    # Debug Toolbar needs to be included early in the list
    "debug_toolbar.middleware.DebugToolbarMiddleware"
] + MIDDLEWARE

INTERNAL_IPS = ["127.0.0.1"]
