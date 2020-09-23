name=input("Enter Your Name: ")
age=int(input("Enter Your Age: "))
salary=int(input("Enter your Basic Salary:"))
assessement_year=int(input("Assessment Year: "))
da=int(input("Enter Dearness Allowance: "))
hra=int(input("Enter HRA:"))
allowance=int(input("Enter your Total Allowance: "))
total_salary=salary+da-hra-allowance
if(age<60):
    if(0<total_salary<250000):
        tax=0
        print(tax)
    elif(250000<total_salary<500000):
        tax=total_salary*0.05
        tax=(0.04*tax)+tax
        print(tax)
    elif(500000<total_salary<1000000):
        tax=12500+(total_salary-500000)*0.2
        tax=(0.04*tax)+tax
        print(tax)
    elif(total_salary>1000000):
        tax=112500+(total_salary-100000)*0.03
        tax=(0.04*tax)+tax
        print(tax)
if(60<age<80):
    if(0<total_salary<300000):
        tax=0
        print(tax)
    elif(300000<total_salary<500000):
        tax=total_salary*0.05
        tax=(0.04*tax)+tax
        print(tax)
    elif(500000<total_salary<1000000):
        tax=10000+(total_salary-500000)*0.2
        tax=(0.04*tax)+tax
        print(tax)
    elif(total_salary>1000000):
        tax=112500+(total_salary-100000)*0.03
        tax=(0.04*tax)+tax
        print(tax)
if(age>80):
    if(0<total_salary<500000):
        tax=0
        print(tax)
    elif(500000<total_salary<1000000):
        tax=(total_salary-500000)*0.2
        tax=(0.04*tax)+tax
        print(tax)
    elif(total_salary>1000000):
        tax=100000+(total_salary-100000)*0.03
        tax=(0.04*tax)+tax
        print(tax)
total_salary=total_salary-tax-50000
deduction=int(input("Enter deductions amount if any under Section 80: "))
total_salary=total_salary-deduction
print("Total Gross Taxable Income of",name,"in the year",assessement_year,"is",total_salary)