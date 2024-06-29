from Components.Xsram import Xsram

class Dcim:
    def __init__(self, rows: int, columns: int, xSrams: list[list[Xsram]]) -> None:
        self._rows = rows
        self._columns = columns
        self._xSrams = xSrams

    def get_rows(self) -> int:
        return self._rows

    def get_columns(self) -> int:
        return self._columns

    def get_xSrams(self) -> list[list[Xsram]]:
        return self._xSrams.copy()
    
    def __repr__(self) -> str:
        return "\n".join(["".join([str(xSram) if xSram else 'Empty' for xSram in row]) for row in self._xSrams])