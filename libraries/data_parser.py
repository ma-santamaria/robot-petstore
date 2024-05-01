import collections


def getTotalByName(pet_names):
    counter = collections.Counter(pet_names)
    return dict(counter)
