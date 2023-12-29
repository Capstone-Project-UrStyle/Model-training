import os
import json

test_json = json.load(open("data/label/test_no_dup.json"))

# Save image ids and features in a dictionary.
test_features = dict()
k=0
image_paths = []
for image_set in test_json:
    set_id = image_set["set_id"]
    for image in image_set["items"]:
        filename = os.path.join("data/images", set_id,
                                str(image["index"]) + ".jpg")
        image_paths.append('public/images/items/app_item_%s.png' % (k))
        os.system('cp %s test-images/app_item_%s.png' % (filename, k))
        k += 1

# Specify the file path
file_path = 'image_paths.json'

# Dump array to JSON file
with open(file_path, 'w') as json_file:
    json.dump(image_paths, json_file)