import os

class DecoderGenerator:
    @staticmethod
    def generate_decoder(n):
        spice_code = ""
        if n == 1:
            # Base case: 1-to-2 decoder
            spice_code += f"* 1-to-2 Decoder\n"
            spice_code += f".subckt decoder1to2 en a1 out0 out1 vdd vss\n"
            spice_code += f"Xinv1 a1 abar1 vdd vss inv\n"
            spice_code += f"Xand1 en abar1 out0 vdd vss and2\n"
            spice_code += f"Xand2 en a1 out1 vdd vss and2\n"
            spice_code += f".ends\n\n"
        else:
            # Generate lower-order decoder
            lower_n = n - 1
            lower_decoder = DecoderGenerator.generate_decoder(lower_n)
            spice_code += lower_decoder

            # Generate current decoder
            spice_code += f"* {n}-to-{2**n} Decoder\n"
            spice_code += f".subckt decoder{n}to{2**n} en " + \
                        ' '.join([f"a{i}" for i in range(1, n+1)]) + ' ' + \
                        ' '.join([f"out{i}" for i in range(2**n)]) + " vdd vss\n"

            # Invert the nth input
            spice_code += f"Xinv{n} a{n} abar{n} vdd vss inv\n"

            # AND en signal with a{n} and abar{n}
            spice_code += f"Xand_low en abar{n} en_abar{n} vdd vss and2\n"
            spice_code += f"Xand_high en a{n} en_a{n} vdd vss and2\n"

            # Instantiate two lower-order decoders
            lower_inputs = ' '.join([f"a{i}" for i in range(1, n)])
            lower_outputs_low = ' '.join([f"out{i}" for i in range(0, 2**(n-1))])
            lower_outputs_high = ' '.join([f"out{i}" for i in range(2**(n-1), 2**n)])

            spice_code += f"Xdec_low en_abar{n} {lower_inputs} {lower_outputs_low} vdd vss decoder{lower_n}to{2**(n-1)}\n"
            spice_code += f"Xdec_high en_a{n} {lower_inputs} {lower_outputs_high} vdd vss decoder{lower_n}to{2**(n-1)}\n"

            spice_code += f".ends\n\n"

        return spice_code

    @staticmethod
    def generate_file(n, file_path):
        # Generate the SPICE code for the decoder
        spice_code = ""

        # Include basic gates
        spice_code += """*** decoder ***
.option nomod captable=1
.lib'rf018.l'TT
.temp 27

*power supply*
VDD VDD 0 1.8
VSS VSS 0 0\n\n"""
        spice_code += "*** Basic logic gates ***\n"
        spice_code += ".subckt inv IN OUT VDD VSS\n"
        spice_code += "MN_inv OUT IN VSS VSS nch W=1U L=0.18U\n"
        spice_code += "MP_inv OUT IN VDD VDD pch W=3.55U L=0.18U\n"
        spice_code += ".ends\n\n"

        spice_code += ".subckt and2 a1 a2 and_out vdd vss\n"
        spice_code += "MN1 n1 a1 n2 vss nch W=1U L=0.18U\n"
        spice_code += "MN2 n2 a2 vss vss nch W=1U L=0.18U\n"
        spice_code += "MP1 n1 a1 vdd vdd pch W=1U L=0.18U\n"
        spice_code += "MP2 n1 a2 vdd vdd pch W=1U L=0.18U\n"
        spice_code += "Xinv_and n1 and_out vdd vss inv\n"
        spice_code += ".ends\n\n"

        # Generate decoders
        spice_code += DecoderGenerator.generate_decoder(n)

        # Output the SPICE code
        output_filename = f"decoder{n}to{2**n}.sp"
        file_path = os.path.join(file_path, output_filename)
        with open(file_path, 'w') as f:
            f.write(spice_code)

        print(f"A {n}-to-{2**n} decoder SPICE module has been generated and saved in {file_path}.")