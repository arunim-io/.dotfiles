local django = require("django")

local plugin = django.setup()

print("Django project detected:", plugin.in_project)
