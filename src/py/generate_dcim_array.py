from Generator.DcimGenerator import DcimGenerator

rows = int(input("Enter the number of rows: "))
columns = int(input("Enter the number of columns: "))
file_path = input("Enter the full path of the file: ")

dcim = DcimGenerator.generate(rows, columns)
DcimGenerator.generate_file(dcim, file_path)