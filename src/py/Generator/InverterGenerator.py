class InverterGenerator:
    @staticmethod
    def generate():
        spice_code = """
*Inverter
.subckt inv in out vdd vss
MN1 out in vss vss nch W=0.30U L=0.10U
MP1 out in vdd vdd pch W=0.60U L=0.10U
.ends
"""
        return spice_code
