from subprocess import check_output as co
import datetime

undefined_key = "'{}' not defined in '{}'"

def process_info(info, site):
    if info['layout'] == 'mep':
        validate_mep(info)
    # site developers should have git
    print(info['fn'])
    an = co(["git", "log", "-1", "--format='%an'", info['fn']])
    # decode to convert to unicode for both Python 2 and 2
    an = an.decode('utf-8')
    an = an.strip("'\n")
    info['an'] = an
    at = co(["git", "log", "-1", "--format='%at'", info['fn']])
    print(at)
    # decode to convert to unicode for both Python 2 and 2
    at = at.decode('utf-8')
    at = at.strip("'\n")
    if at:
        at = datetime.date.fromtimestamp(int(at))
        print(at)
    info['at'] = at

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
