from Generator.DecoderGenerator import DecoderGenerator

n = int(input("Please enter the number of input bits for the decoder n (e.g., 3 means a 3-to-8 decoder):"))
file_path = input("Enter the full path of the file: ")

decoder = DecoderGenerator.generate_file(n, file_path)

