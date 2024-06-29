from Components.Coordinate import Coordinate

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