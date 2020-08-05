from django import template

register = template.Library()

@register.filter(name='replace')
def replace(value, args=","):
    try:
        old, new = args.split(',')
        return value.replace(old, new)
    except ValueError:
        return value