def dateformat(value, format="%d-%b-%Y"):
    return value.strftime(format)

def mepkind(item):
    if item['mep'] < 100:
        return 'Info'
    elif item['status'] == 'Final': 
        return 'Final' 
    else: 
        return 'Open' 

filters = {}
filters['dateformat'] = dateformat
filters['mepkind'] = mepkind
