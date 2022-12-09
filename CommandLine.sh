 #!/bin/sh
 


##### 1.Which location has the maximum number of purchases been made?

first=$(cut -d, -f 5 bank_transactions.csv | sort | uniq -c | sort -n | tail -1)
read -r n location <<<$first
echo Location with maximum number of purchase been made is ${location} with $n purchases!
echo

# COMMENT: At first we get the column of the locations and after sort it we get all the unique values with the number of duplicates. We sort by this number in increasing order, taking the last one. 




###### 2.In the dataset provided, did females spend more than males, or vice versa?

avg_M=$(cut -d, -f 4,9 bank_transactions.csv | grep "M" | cut -d',' -f 2 | awk '{ tot += $1; nj++ } END { print tot / nj }')
avg_F=$(cut -d, -f 4,9 bank_transactions.csv | grep "F" | cut -d',' -f 2 | awk '{ tot += $1; nj++ } END { print tot / nj }')

echo Average amount of transaction of male: $avg_M INR
echo Average amount of transaction of female: $avg_F INR

if [ ${avg_F%.*} -gt ${avg_M%.*} ]
then echo Females spend more than males on average in our dataset!
else echo Males spend more than females on average in our dataset!
fi
echo

# COMMENT: We cannot compare the total amount of the transactions beacuase there are many more men (73%) than women (27%) in the dataset. So we look for the average transaction amount group by gender. To do this we use grep to match all the rows with 'M' or 'F' and then we sum the amounts and divide by the size of the group. So of course 




###### 3.Report the customer with the highest average transaction amount in the dataset.

third=$(cut -d, -f 2,9 bank_transactions.csv | awk -F, '{ customers[$1] += $2; ++nj[$1] } END { for (i in customers) printf "%s %.2f\n", i, customers[i] / nj[i] }' | sort -k2 -n | tail -1)
read -r user average <<<$third
echo The customer with the hightest average transaction amount is $user with $average INR!

# COMMENT: With the awk function we count for every customer the amount of his transactions, summing them, and the number of them. Then we get the mean dividing this two features and, sorting by the column of the means in increasing order, we take the last one.




##### OUTPUT:

# Location with maximum number of purchase been made is MUMBAI with 103595 purchases!

# Average amount of transaction of male: 1610.45 INR
# Average amount of transaction of female: 1721.15 INR
# Females spend more than males on average in our dataset!

# The customer with the hightest average transaction amount is C7319271 with 1560034.99 INR!