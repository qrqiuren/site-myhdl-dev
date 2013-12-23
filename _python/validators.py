undefined_key = "'{}' not defied in '{}'"

def check_keys(item, keys):
    for key in keys:    
        if key not in item:
            raise KeyError(undefined_key.format(key, item['id']))
        
def validate_article(item):
    check_keys(item, ['date'])


status_error = "Invalid status '{}' in '{}'"
defined_statusses = ('Draft', 'Final', 'Rejected', 'Replaced', 'Active')
def validate_mep(item):
    check_keys(item, ['author', 'date', 'mep'])
    if 'status' in item:
        if item['status'] not in defined_statusses:
            raise ValueError(status_error.format(item['status'], item['id']))
    else:
        item['status'] = 'Draft'

validators= {}

validators['article'] = validate_article 
validators['mep'] = validate_mep
