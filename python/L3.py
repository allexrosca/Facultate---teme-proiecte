def p1(a, b):
	a,b = set(a), set(b)
	return (a&b, a|b, b-a, a-b)

def p2(sir):
	return {a : sir.count(a) for a in set(sir)}

def p3(dict1, dict2):
	k1 = set(dict1.keys())
	k2 = set(dict2.keys())
	t1 = k1-k2
	t2 = k2-k1
	setValDiff = {}
	cheiComune = k1&k2
	for k in cheiComune:
		if dict1[k] != dict2[k]:
			setValDiff.add(k)
	isEqual == 0
	if len(k1-k2) and len(k2-k1) and len(setValDiff):
		isEqual == 1
	return (isEqual,setValDiff ,k1-k2, k2-k1)

def build_xml_element(tag, content, **kwargs):
	s = "<" + tag + " "
	for k in kwargs.keys():
		s = s+ k + "=" + kwargs[k] + " "
	s = s[:-1] + ">" + content + "</" + tag + ">"
	return s

def validate_dict(dictionar, rules):
	for rule in rules:
		myStr = dictionar[rule[0]]
		#todo
		if not myStr.startswith(rule[1]) or not myStr.endswith(rule[3]) or myStr.find(rule[2])<=0 or myStr.find(rule[2])==len(myStr)-len(rule[2]):
			return False
	return True


			
gd ={    
    "+": lambda a, b: a + b,     
    "*": lambda a, b: a * b,
    "/": lambda a, b: a / b,
    "%": lambda a, b: a % b
}

def apply_operator(operator, a, b):
	if operator in gd:
		return gd[operator](a,b)

print(validate_dict({"key2": "starting the engine in the middle of the winter", 
	"key1": "come inside, it's too cold outside", "key3": "this is not valid"},
	[("key1", "", "inside", ""), ("key2", "start", "middle", "winter")]))

gd2 ={
    "print_all": lambda *a, **k: print(a, k),
    "print_args_commas": lambda *a, **k: print(a, k, sep=", "),
    "print_only_args": lambda *a, **k: print(a),
    "print_only_kwargs": lambda *a, **k: print(k)
}

def apply_function(operator, *args, **kwargs):
	if operator in gd2:
		return gd2[operator](args,kwargs)


apply_function("print_all", 2, 3, 4, 5)

def p8(set1):
	return (len(set1), 0)

def buildDict(*args):
	myDict = {}
	for elem1 in args:
		for elem2 in args:
			if(elem1!=elem2):
				myDict[str(elem1) + "|" + str(elem2)] = elem1|elem2
				myDict[str(elem1) + "&" + str(elem2)] = elem1&elem2
				myDict[str(elem1) + "-" + str(elem2)] = elem1-elem2
	return myDict


print(buildDict({2,3}, {4,5}))