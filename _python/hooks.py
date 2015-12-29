undefined_key = "'{}' not defined in '{}'"

def process_info(info, site):
    if info['layout'] == 'mep':
        validate_mep(info)

def check_keys(item, keys):
    for key in keys:    
        if key not in item:
            raise KeyError(undefined_key.format(key, item['id']))

status_error = "Invalid status '{}' in '{}'"
defined_statusses = ('Draft', 'Final', 'Rejected', 'Replaced', 'Active')
def validate_mep(info):
    check_keys(info, ['author', 'date', 'mep'])
    if 'status' in info:
        if info['status'] not in defined_statusses:
            raise ValueError(status_error.format(info['status'], info['id']))
    else:
        item['status'] = 'Draft'



