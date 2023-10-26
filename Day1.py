sales=3000
print(sales)
sales = 3000
print(sales)
Sales = 5000
print(Sales)
print(sales)

if sales > 1000:
    print('Good Sales!')
    print('Thank You!')
else:
    print('OH OH!!!')

print('\n\n###### VARIABLES #####')
total_sales = 9000

if total_sales > 5000:
    _msg = 'We did a good job'
    print(_msg)
else:
    print('We could do more.')

print(type(_msg))
print(type(total_sales))

married = True
male = False

print(type(married))
print(type(male))

bank_balance = None

print(type(bank_balance))

name = str("Maddy")
age = str(54)

print(type(name))
print(type(age))

python_web_msg = """Active Python Releases
For more information visit the Python Developer's Guide."""

python_web_msg = '''Active Python Releases
For more information visit the Python Developer's Guide.'''

print(type(python_web_msg), ':', len(python_web_msg))

if 'ease' in python_web_msg:
    print("'ease' was found in 'python_web_msg'")
else:
    print("'ease' was NOT found in 'python_web_msg'")

a = True
print(a)

print(10 > 9)
print(10 == 9)
print(10 < 9)

a = 200
b = 33
if b > a:
    print("b is greater than a")
else:
    print("b is not greater than a")

x = "Hello"
y = 0
print(bool(x))
print(bool(y))

print(float(3))
print(int(3.654))

print('\n\n###### OPERATORS #####')
print(7 // 4)
print(7 % 4)

x = 9
x += 8  # x = x + 8
print(x)

print(x**2)

y = 17

print(x is str)
print(x is y)

print( x is y or x>2)
print( y > 5 and x>19)
print( y > 5 and not x>19)
