import os

class Coordinate:
    def __init__(self, row: int, column: int) -> None:
        self.row = row
        self.column = column

    def __repr__(self) -> str:
        return f"Coordinate(row={self.row}, column={self.column})"

class Xsram:
    def __init__(self, wl: int, blb: int, bl: int, in_b: int, out: Coordinate, vdd_name: str = "vdd", vss_name: str = "vss") -> None:
        self.wl = wl
        self.blb = blb
        self.bl = bl
        self.in_b = in_b
        self.out = out
        self.vdd_name = vdd_name
        self.vss_name = vss_name

    def __repr__(self) -> str:
        return (f"Xsram(wl={self.wl}, blb={self.blb}, bl={self.bl}, "
                f"in_b={self.in_b}, out={self.out}, vdd_name={self.vdd_name}, vss_name={self.vss_name})\n")

class Dcim:
    def __init__(self, rows: int, columns: int) -> None:
        self.rows = rows
        self.columns = columns
        self.grid: list[list[Xsram]] = [[None for _ in range(columns)] for _ in range(rows)]

    def add_cell(self, row: int, column: int, cell: Xsram) -> None:
        if 0 <= row < self.rows and 0 <= column < self.columns:
            self.grid[row][column] = cell
        else:
            raise IndexError("Cell position out of range")

    def get_cell(self, row: int, column: int) -> Xsram:
        if 0 <= row < self.rows and 0 <= column < self.columns:
            return self.grid[row][column]
        else:
            raise IndexError("Cell position out of range")

    def __repr__(self) -> str:
        return "\n".join(["".join([str(cell) if cell else 'Empty' for cell in row]) for row in self.grid])


def generate_dcim(rows: int, columns: int) -> Dcim:
    dcim = Dcim(rows, columns)
    for row in range(rows):
        for column in range(columns):
            # Create a Xsram object with the given row, column, and Coordinate
            wl = row
            blb = column
            bl = column
            in_b = row
            dcim.add_cell(row, column, Xsram(wl, blb, bl, in_b, Coordinate(row, column)))
    return dcim

# Xsram1 wl0 blb0 bl0 in_b0 out0 vdd vss
def generate_dcim_spice(dcim: Dcim, file_path: str) -> str:
    spice = f"""*** {dcim.rows}x{dcim.columns} DCIM_ARRAY ***
.option nomod 
.lib'0.18umCMOSModel.l'TT
.temp 27

*power supply*
VDD VDD 0 1.2
Vwl0 wl0 0 1.2
VSS VSS 0 0

.subckt sram_nor WL BLB BL IN_B OUT VDD VSS
MN1 Q QB VSS VSS nch  W= 0.30U L= 0.10U
MN2 QB Q VSS VSS nch  W= 0.30U L= 0.10U
MN3 QB WL BLB VSS nch  W= 0.60U L= 0.10U
MN4 Q WL BL VSS nch  W= 0.60U L= 0.10U
MN5 OUT QB VSS VSS nch  W= 0.60U L= 0.10U
MN6 OUT IN_B VSS VSS nch  W= 0.60U L= 0.10U
MP1 Q QB VDD VDD pch  W= 0.60U L= 0.10U
MP2 QB Q VDD VDD pch  W= 0.60U L= 0.10U
MP3 OUT IN_B N1 VDD pch  W= 0.60U L= 0.10U
MP4 N1 QB VDD VDD pch  W= 0.60U L= 0.10U
.ends

"""

    for row in range(dcim.rows):
        for column in range(dcim.columns):
            cell = dcim.get_cell(row, column)
            spice += (f"Xsram{row}_{column} wl{cell.wl} blb{cell.blb} bl{cell.bl} in_b{cell.in_b} "
                      f"out{cell.out.row}_{cell.out.column} {cell.vdd_name} {cell.vss_name}\n")
    
    file_name = f"{dcim.rows}x{dcim.columns}_dcim.sp"
    file_path = os.path.join(file_path, file_name)
    with open(file_path, 'w') as f:
        f.write(spice)
    
    return spice


# main
rows = int(input("Enter the number of rows: "))
columns = int(input("Enter the number of columns: "))
dcim = generate_dcim(rows, columns)
print(generate_dcim_spice(dcim, "D:\\repos\money_create\\res"))