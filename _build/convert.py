import sys
import re

fn = sys.argv[1]

heading = re.compile(r'([^=]*).*')
code_inline = re.compile(r"''(.*?)''")
escape = re.compile(r"%%(.*?)%%")
code_python = re.compile(r'<code python>')
endcode = re.compile(r'</code>')

with open(fn) as f:
    print '---'
    for line in f:
        if line[:6] == '======':
            m = heading.match(line[6:])
            if m: 
                print 'title: ', m.group(1)
        elif line[:5] == '=====':
            m = heading.match(line[5:])
            if m: 
                h = m.group(1).strip()
                print h 
                print '=' * len(h)
        elif line[:4] == '====':
            m = heading.match(line[4:])
            if m: 
                h = m.group(1).strip()
                print h 
                print '-' * len(h)
        else:
            line = line[:-1]
            line = escape.sub(r'\1', line)
            line = code_inline.sub(r'`\1`', line)
            line = code_python.sub(r'```python', line)
            line = endcode.sub(r'```', line)
            print line
