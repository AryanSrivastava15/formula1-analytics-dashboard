import csv

input_file = r'c:\Users\Aryan\Documents\f1-performance-analysis\data\drivers.csv'
output_file = r'c:\Users\Aryan\Documents\f1-performance-analysis\data\drivers.sql'

with open(input_file, 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    header = next(reader)
    # Strip quotes from header
    header = [h.strip('"') for h in header]
    table_name = 'drivers'
    rows = []
    for row in reader:
        values = []
        for cell in row:
            if cell == 'NULL':
                values.append('NULL')
            elif cell.isdigit():
                values.append(cell)
            else:
                # string
                values.append(f"'{cell}'")
        rows.append(f"({', '.join(values)})")

    sql = f"INSERT INTO {table_name} ({', '.join(header)}) VALUES\n" + ',\n'.join(rows) + ';'

with open(output_file, 'w', encoding='utf-8') as f:
    f.write(sql)

print(f"SQL INSERT query saved to {output_file}")