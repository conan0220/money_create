class Coordinate:
    def __init__(self, row: int, column: int) -> None:
        self.row = row
        self.column = column

    def __repr__(self) -> str:
        return f"Coordinate(row={self.row}, column={self.column})"