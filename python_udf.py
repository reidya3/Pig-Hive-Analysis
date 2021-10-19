 #/usr/bin/python3

@outputSchema("condition_met:boolean")
def most_liked_condition(ratings):
    ratings_list = [float(x) for x in str(ratings).split("|")]
    count_greater_than_four = 0
    for rating in ratings_list:
        if rating >= 4:
            count_greater_than_four += 1
    if count_greater_than_four == len(ratings_list) or ratings_list.count(5) >= (0.5 * len(ratings_list)):
        return True
    return False
