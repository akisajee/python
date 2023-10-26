####################PANDAS######################
import random

import pandas
import pandas as pd
import sqlalchemy
from scipy.stats import trim_mean
from sqlalchemy import text


class pandasEngine():
    def loadData(self):
        self.mallC = pd.read_csv('D:\TSOM\PData\Mall_Customers.csv')
        print(self.mallC.to_string())

    def loadSQLData(self):
        engine = sqlalchemy.create_engine(
            "mysql+pymysql://root:da12345@localhost/test2")
        conn = engine.connect()
        print(conn)
        df = pd.read_sql(text("""SELECT * 
            FROM test2.buyers"""), conn)
        print(df)
        conn.close()

    def demonstrateSeries(self):
        marks1 = [67, 80, 90, 60, 54, 93, 99, 74, 50, 85 ]
        sMarks1 = pd.Series(marks1)
        print(sMarks1)

        print(sMarks1[0])
        print(sMarks1[:4])

        marks2 = ["67", 98, 45, 91, 67, 99, 100]
        sMarks2 = pd.Series(marks2)
        print(sMarks2)

        print(list(sMarks2))

        students = ['S' + str(x) for x in range(1,11)]
        sMarks3 = pd.Series(marks1, index= students)
        print(sMarks3)

        print(sMarks3["S2"])
        print(sMarks3[["S2","S4"]])

        dict1 = {
            "P1":176,
            "P2":140,
            "P3":180,
            "P4":177,
            "P5":153,
            "P6":130
        }

        sHeight = pd.Series(dict1)
        print(sHeight)

        labels = list("abcdefghij")
        nums = [random.uniform(10,100) for x in range(10)]

        sNums = pd.Series(nums,labels)
        print(sNums)

        print(sMarks3)
        sMarks4 = pd.Series([random.uniform(10,100) for x in range(10)], students)
        print(sMarks4)



        sTotalMarks = sMarks3.add(sMarks4)
        print(sTotalMarks)

        print(sMarks3.add(sMarks1))

        sNums1 = pd.Series([random.uniform(10,100) for x in range(10)])
        sNums2 = pd.Series([random.uniform(10, 100) for x in range(8)])

        print(sNums1.add(sNums2))

        print(sum(sNums1))
        print(sNums1.sum())
        print(sNums1.mean())

        prods = {
            "P1": 50,
            "P2":60,
            "P3":12
        }

        sProds = pd.Series(prods)
        print(sProds)
        sProds = sProds.map("{} USD".format)
        print(sProds)

        sGenders = pd.Series(["M", "M", "F", "F", "NB", "NB", "NB", "F", "M", "NB"])
        gender_ids = {
            "M" : 0,
            "F" : 1,
            "NB": 0
        }
        mapped_Genders = sGenders.map(gender_ids)
        print(mapped_Genders)

        prods = {
            "P1": 50,
            "P2": 60,
            "P3": 12,
            "P4": 70,
            "P5": 20
        }

        def discount(x):
            if x >= 50: return(x*.9)
            else: return(x)

        sProds = pd.Series(prods)
        print("Prod Prices in USD")
        print(sProds)

        print("Prod Prices in CAD")
        print(sProds.mul(1.34))
        print("Prod Prices in CAD after discount")
        print((sProds.mul(1.34)).apply(discount))

    def doEx1(self):
        self.loadData()
        aIncome = self.mallC["Annual Income (k$)"]
        print("1. A.Income Mean:"+str(aIncome.mean()))
        print("2. A.Income 15% Trimmed Mean:"+str(trim_mean(aIncome,0.15)))
        print("3. A.Income Sum:"+str(aIncome.sum()))
        print("4. A.Income Count:"+str(aIncome.count()))
        print("5. A.Income Size:"+str(aIncome.size))
        print("6. Are A.Income Values Unique?"+str(aIncome.is_unique))

        aIncomeSorted = aIncome.sort_values()
        randNums = [random.uniform(aIncome.min(),aIncome.max()) for x in range(len(aIncome))]

        aIncome_adds = aIncome.add(randNums)
        print(aIncome_adds)

        aIncome_mul= aIncome.mul(randNums)
        print(aIncome_mul)

        aIncome_gt= aIncome.gt(randNums)
        print(aIncome_gt.to_string())

        def incomeStatus(val, valSeries):
            meanV = valSeries.mean()
            returnV = ""
            if val < .75*meanV: returnV = "low_income"
            elif val > .75*meanV: returnV = "high_income"
            else: returnV = "mid_income"
            return(returnV)

        aIncomeStatus = aIncome.apply(incomeStatus,args=[aIncome])
        print(aIncomeStatus)

#pandas.options('max.rows', None)
#pandas.options('max.columns', None)


pe = pandasEngine()
#pe.loadData()
#pe.loadSQLData()
#pe.demonstrateSeries()
pe.doEx1()


#pandas.reset_option(all)