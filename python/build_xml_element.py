def build_xml_element(tag, content, **args):
    str = "<" + tag + " "
    for e in args:
        str = str + e + "=" + "\\\"" + args[e] + "\\\"" + " "
    str = str + ">" + content + "</" + tag + ">"
    return str


print(build_xml_element("a", "Hello there", href="http://python.org", _class="my-link", id="someid") )