from Components.Coordinate import Coordinate
from Components.Xsram import Xsram
from Components.Dcim import Dcim

import os

class DcimGenerator:
    _rows: int
    _columns: int
    _xSrams: list[list[Xsram]]
    _dcim: Dcim
    _spice: str
    _xSram: Xsram
    _row: int
    _column: int
    _fileName: str
    _filePath: str
    _fileFullPath: str

    @staticmethod
    def generate_dcim_by_rows_and_columns(rows, columns) -> Dcim:
        DcimGenerator._set_rows_and_columns(rows, columns)
        DcimGenerator._set_xSrams()
        DcimGenerator._set_dcim_by_rows_columns_xSrams()
        return DcimGenerator._dcim
    
    @staticmethod
    def _set_rows_and_columns(rows, columns):
        DcimGenerator._rows = rows
        DcimGenerator._columns = columns
    
    @staticmethod
    def _set_xSrams():
        DcimGenerator._initialize_xSrams()
        DcimGenerator._assign_xSrams_rows()
    
    @staticmethod
    def _initialize_xSrams():
        DcimGenerator._xSrams = [[Xsram] * DcimGenerator._columns for _ in range(DcimGenerator._rows)]
    
    @staticmethod
    def _assign_xSrams_rows():
        for row in range(DcimGenerator._rows):
            DcimGenerator._assign_xSrams_columns_by_row(row)

    @staticmethod
    def _assign_xSrams_columns_by_row(row: int) -> None:
        for column in range(DcimGenerator._columns):
            wl = row
            blb = column
            bl = column
            in_b = row
            DcimGenerator._xSrams[row][column] = Xsram(wl, blb, bl, in_b, Coordinate(row, column))

    @staticmethod
    def _set_dcim_by_rows_columns_xSrams():
        DcimGenerator._dcim = Dcim(DcimGenerator._rows, DcimGenerator._columns, DcimGenerator._xSrams)

    @staticmethod
    def generate_spice_by_dcim_and_filePath(dcim, file_path):
        DcimGenerator._set_dcim(dcim)
        DcimGenerator._set_filePath(file_path)
        DcimGenerator._write_basic_simulation_setting_to_spice()
        DcimGenerator._write_instances_of_sram_nor_to_spice()
        DcimGenerator._generate_spice_file()
    
    @staticmethod
    def _set_dcim(dcim):
        DcimGenerator._dcim = dcim

    @staticmethod
    def _set_filePath(file_path):
        DcimGenerator._filePath = file_path

    @staticmethod
    def _write_basic_simulation_setting_to_spice():
        DcimGenerator._write_title_to_spice()
        DcimGenerator._write_simulation_configuration_to_spice()
        DcimGenerator._write_power_supply_to_spice()
        DcimGenerator._write_sram_nor_definition_to_spice()

    @staticmethod
    def _write_title_to_spice():
        rows = DcimGenerator._dcim.get_rows()   
        columns = DcimGenerator._dcim.get_columns()
        DcimGenerator._spice = f"*** {rows}x{columns} DCIM_ARRAY ***\n"

    @staticmethod
    def _write_simulation_configuration_to_spice():
        DcimGenerator._spice += """.option nomod 
.lib'0.18umCMOSModel.l'TT
.temp 27

"""

    @staticmethod
    def _write_power_supply_to_spice():
        DcimGenerator._spice += """*power supply*
VDD VDD 0 1.2
VSS VSS 0 0

"""

    @staticmethod
    def _write_sram_nor_definition_to_spice():
        DcimGenerator._spice += """.subckt sram_nor WL BLB BL IN_B OUT VDD VSS
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
    @staticmethod
    def _write_instances_of_sram_nor_to_spice():
        rows = DcimGenerator._dcim.get_rows()
        columns = DcimGenerator._dcim.get_columns()
        DcimGenerator._set_rows_and_columns(rows, columns)
        for row in range(DcimGenerator._rows):
            for column in range(DcimGenerator._columns):
                DcimGenerator._set_row_and_column(row, column)
                xSram = DcimGenerator._get_xSram_from_dcim()
                DcimGenerator._set_xSram(xSram)
                DcimGenerator._write_xSram_to_spice()
    
    @staticmethod
    def _set_row_and_column(row, column):
        DcimGenerator._row = row
        DcimGenerator._column = column
    
    @staticmethod
    def _get_xSram_from_dcim():
        return DcimGenerator._dcim.get_xSrams()[DcimGenerator._row][DcimGenerator._column]

    @staticmethod
    def _set_xSram(xSram):
        DcimGenerator._xSram = xSram

    @staticmethod
    def _write_xSram_to_spice():
        DcimGenerator._spice += f"Xsram{DcimGenerator._row}_{DcimGenerator._column} "
        DcimGenerator._spice += f"wl{DcimGenerator._xSram.wl} blb{DcimGenerator._xSram.blb} "
        DcimGenerator._spice += f"bl{DcimGenerator._xSram.bl} in_b{DcimGenerator._xSram.in_b} "
        DcimGenerator._spice += f"out{DcimGenerator._xSram.out.row}_{DcimGenerator._xSram.out.column} "
        DcimGenerator._spice += f"{DcimGenerator._xSram.vdd_name} {DcimGenerator._xSram.vss_name} sram_nor\n"

    @staticmethod
    def _generate_spice_file():
        DcimGenerator._set_fileName()
        DcimGenerator._set_fileFullPath()
        DcimGenerator._write_spice_to_file()

    @staticmethod
    def _set_fileName():
        DcimGenerator._fileName = f"{DcimGenerator._dcim.get_rows()}x{DcimGenerator._dcim.get_columns()}_dcim.sp"
    
    @staticmethod
    def _set_fileFullPath():
        DcimGenerator._fileFullPath = os.path.join(DcimGenerator._filePath, DcimGenerator._fileName)

    @staticmethod
    def _write_spice_to_file():
        with open(DcimGenerator._fileFullPath, 'w') as f:
            f.write(DcimGenerator._spice)