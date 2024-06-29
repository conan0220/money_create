from Generator.DcimGenerator import DcimGenerator

rows = int(input("Enter the number of rows: "))
columns = int(input("Enter the number of columns: "))
file_path = input("Enter the full path of the file: ")

dcim = DcimGenerator.generate_dcim_by_rows_and_columns(rows, columns)
DcimGenerator.generate_spice_by_dcim_and_filePath(dcim, file_path)