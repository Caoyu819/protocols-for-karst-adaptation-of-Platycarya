__author__ = "Fabio H. K. Mendes"
import os
import argparse
def clade_filter(mcl_dump, clade_str):
    lines_to_keep_list = list()
    spp_idx_dict = dict()
    clades_list = list()
    if clade_str: # if clade filter was specified
        clades_list = clade_str.split(" ")
    with open(mcl_dump, "r") as input_file:
        for line_n, line in enumerate(input_file):
            line = line.rstrip()
            tokens = line.split("\t")
            spp_info = tokens[2:]
            if line.startswith("Desc"):
                spp_idx_dict = dict((sp, idx) for idx,sp in enumerate(spp_info))
                continue
            if clades_list:                
                clades_ok_list = list()
                for clade in clades_list:
                    spp_list = clade.split(",")
                    clade_count = sum(1 for sp in spp_list if int(spp_info[spp_idx_dict[sp]]) >= 1)
                    if clade_count >= 2:
                        clades_ok_list.append(1)
                if sum(clades_ok_list) == len(clades_list):
                    lines_to_keep_list.append(line_n)               
            # just keeping lines where >=2 species (among all of them) have gene copies
            clade_count = sum(1 for sp_count in spp_info if int(sp_count) >= 1)
            if clade_count >= 2:
                lines_to_keep_list.append(line_n)              
    return set(lines_to_keep_list)
def size_filter(mcl_dump, lines_to_keep_set):
    lines_to_remove_set = set()
    size_cutoff = 100
    fam_size = int()
    with open(mcl_dump, "r") as input_file:
        for line_n, line in enumerate(input_file):
            line = line.rstrip()
            if line.startswith("Desc"):
                continue
            elif line_n not in lines_to_keep_set and len(lines_to_keep_set) > 0:
                continue
            tokens = line.split("\t")
            spp_info = tokens[2:]
            for gene_count in spp_info:
                if int(gene_count) >= size_cutoff:
                    lines_to_separate_set.add(line_n)                 
    lines_to_keep_set -= lines_to_separate_set
    return lines_to_keep_set, lines_to_separate_set
def filter_print(mcl_dump, lines_to_keep_set, lines_to_separate_set, output_file_name):
    if len(lines_to_keep_set) == 0 and len(lines_to_separate_set) == 0:
        exit("No filtering was done! Exiting...\n")
    with open(output_file_name, "w") as output_file:
        with open("large_"+output_file_name, "w") as output_file2:
            with open(mcl_dump, "r") as input_file:
                for line_n, line in enumerate(input_file):
                    line = line.rstrip() + "\n"
                    if line_n == 0:
                        output_file.write(line)
                        output_file2.write(line) 
                    elif line_n in lines_to_keep_set and len(lines_to_keep_set) >= 1:
                        output_file.write(line)
                    elif line_n not in lines_to_separate_set and len(lines_to_keep_set) == 0:
                        output_file.write(line)
                    # has to be if, not elif
                    if line_n in lines_to_separate_set:
                        output_file2.write(line)
        # cleaning up in case size filtering was not done
        if len(lines_to_separate_set) == 0:
            os.unlink("large_"+output_file_name)
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__, prog="cafetutorial_clade_and_size_filter.py")
    parser.add_argument("-i", "--input-file", action="store", dest="input_file", required=True, type=str, help="full path to mcl's output dump file")
    parser.add_argument("-o", "--output-file", action="store", dest="output_file", required=True, type=str, help="full path to file to be written")
    parser.add_argument("-cl", "--clade-filter", action="store", dest="clade_str", default=None, required=False, type=str, help="list of clades (separated by white spaces) comprised of species identifiers (separated by comma) that must have at least two species with gene copies for a given gene family")
    parser.add_argument("-s", "--size-filter", action="store_true", dest="size_filter", required=False, help="option to perform size filtering")
    args = parser.parse_args()
    lines_to_keep_set, lines_to_separate_set = set(), set()
    # applying size filter (if no groups are specified, just the lines where just 1 species has gene counts are removed
    lines_to_keep_set = clade_filter(args.input_file, args.clade_str)
    if args.size_filter:
        lines_to_keep_set, lines_to_separate = size_filter(args.input_file, lines_to_keep_set)
    filter_print(args.input_file, lines_to_keep_set, lines_to_separate_set, args.output_file) # .add(0) to get header back
