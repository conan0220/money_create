import os
import csv
import re
import sys

# 定義關鍵字
keywords = [
    "tread1_delay", "tread1_slew", "tread1_wl_delay", "tread1_se_delay",
    "tread0_delay", "tread0_slew", "tread0_wl_delay", "tread0_se_delay"
]

# 從命令行參數中取得資料夾名稱
if len(sys.argv) < 2:
    print("請提供資料夾名稱！")
    sys.exit(1)

folder_name = sys.argv[1]

# 切換到指定資料夾
os.chdir(folder_name)

# 建立 CSV 檔案
csv_filename = f"{folder_name}.csv"
with open(csv_filename, mode='w', newline='') as csvfile:
    # 定義 CSV 標題
    fieldnames = ["address"] + keywords
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

    # 遍歷資料夾內的所有 .lis 檔案
    for filename in os.listdir('.'):
        if filename.endswith('.lis'):
            # 取得檔案最後的數字 (address)
            address_match = re.search(r'_tt_(\d+)\.lis$', filename)
            if not address_match:
                continue
            address = int(address_match.group(1))

            # 開啟檔案並搜尋關鍵字
            data = {"address": address}
            with open(filename, 'r') as file:
                content = file.read()

                # 搜尋每個關鍵字的數值
                for keyword in keywords:
                    match = re.search(rf'{keyword}=\s*([\d.Ee+-]+)', content)
                    if match:
                        data[keyword] = match.group(1)
                    else:
                        data[keyword] = None  # 如果沒找到數值則留空

            # 將資料寫入 CSV
            writer.writerow(data)

print(f"已完成，結果存入 {csv_filename} 中。")
