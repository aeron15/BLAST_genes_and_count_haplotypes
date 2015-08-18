"""
Computes mean of a file
"""

#open file
with open('cov_r1A10', 'r') as f:
    #read lines, strip trailing newlines, and convert to float if not empty
    numbers = [float(x) for x in (x.strip() for x in f) if x]

avg = sum(numbers) / len(numbers)
sdv = (sum((n - avg) ** 2 for n in numbers) / len(numbers)) ** .5
print('The arithmetic mean is {}'.format(avg))
print('The standard deviation is {}'.format(sdv))
print('The minimum is {}.'.format(min(numbers)))
