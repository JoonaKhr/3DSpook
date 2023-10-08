extends Node3D

var itemList = []

func obtainItem(item):
    itemList.append(item)

func removeItem(item):
    itemList.erase(item)
