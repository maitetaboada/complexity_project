import argparse
import os
import random
from shutil import copyfile

def main(folder_path, random_size):
	if os.path.exists(folder_path):
		files = os.listdir(folder_path)
		if len(files) < random_size:
			raise ValueError("The random sample size is larger than the number of files in this folder!")
		dest_folder = "_".join(folder_path.split('/')) + "_" \
		+ str(random_size) + "_random_files"
		if not os.path.exists(dest_folder):
			os.makedirs(dest_folder)
		else:
			dest_folder += "_NEW"
			os.makedirs(dest_folder)
		sampled_file = [files[i] for i in random.sample(range(len(files)),random_size)]
		for f in sampled_file:
			copyfile(folder_path + '/' + f, dest_folder + '/' + f)
	else:
		print("There is no such folder, the path is wrong")

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='generating random files from one folder')
	parser.add_argument('path', metavar='path', type=str,
                    help='the path to folder we want to generate files from')
	parser.add_argument('random_size', metavar='random_size', type = int,
                    help='random sample size')
	args = parser.parse_args()
	main(args.path, args.random_size)