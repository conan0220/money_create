class ANDGateGenerator:
    @staticmethod
    def generate(n):
        def generate_mosfets(n):
            mosfets = []
            # Generate NMOS transistors
            for i in range(1, n + 1):
                if i == 1:
                    mosfets.append(f"MN{i} n{i} a{i} n{i+1} vss nch W=0.60U L=0.10U")
                else:
                    mosfets.append(f"MN{i} n{i} a{i} vss vss nch W=0.60U L=0.10U")
            
            # Generate PMOS transistors
            for i in range(1, n + 1):
                mosfets.append(f"MP{i} n1 a{i} vdd vdd pch W=0.60U L=0.10U")
            
            return "\n".join(mosfets)

        mosfets = generate_mosfets(n)
        spice_code = f"""
*{n}-input AND gate
.subckt and{n} {" ".join([f"a{i}" for i in range(1, n + 1)])} and_out vdd vss
{mosfets}
Xinv n1 and_out vdd vss inv
.ends
"""
        return spice_code