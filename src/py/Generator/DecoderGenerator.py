import os

from Generator.InverterGenerator import InverterGenerator
from Generator.ANDGateGenerator import ANDGateGenerator

class DecoderGenerator:
    @staticmethod
    def generate(n, m):
        spice_code = """
*** 8-to-1 decoder ***
.option nomod 
.lib'0.18umCMOSModel.l'TT
.temp 27


*power supply*
VDD VDD 0 1.8
VSS VSS 0 0
"""
        spice_code += InverterGenerator.generate()
        spice_code += ANDGateGenerator.generate(n)

        # Generating the inverters for each input
        inverters = "\n".join([f"Xinv{i} a{i} abar{i} vdd vss inv" for i in range(1, n + 1)])

        # Generating the AND gates for the decoder outputs
        and_gates = []
        for i in range(m):
            and_inputs = []
            for j in range(n):
                # Determine whether to use the original or inverted input based on the binary representation
                if (i >> j) & 1:
                    and_inputs.append(f"a{j+1}")
                else:
                    and_inputs.append(f"abar{j+1}")
            and_gates.append(f"Xand{i+1} {' '.join(and_inputs)} and_out{i+1} vdd vss and{n}")
        
        and_gates_str = "\n".join(and_gates)

        spice_code += f"""
*{n}-to-{m} Decoder
{inverters}
{and_gates_str}
.ends
"""
        return spice_code
    
    @staticmethod
    def generate_file(row, col, file_path):
        file_name = f"{row}-to-{col}_decoder.sp"
        file_path = os.path.join(file_path, file_name)
        spice_code = DecoderGenerator.generate(row, col)
        with open(file_path, "w") as file:
            file.write(spice_code)

def subckt_definition(n, m):
    inputs = " ".join([f"a{i}" for i in range(1, n + 1)])
    outputs = " ".join([f"and_out{i}" for i in range(1, m + 1)])
    return f".subckt decoder{n}to{m} {inputs} {outputs} vdd vss"

