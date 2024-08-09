from Generator.DecoderGenerator import DecoderGenerator

n = int(input("Enter the number of inputs: "))
m = int(input("Enter the number of outputs: "))
file_path = input("Enter the full path of the file: ")

decoder = DecoderGenerator.generate_file(n, m, file_path)

