#from snakemake import rules
#rule first_rule:
#	input:
#		"input.txt",
#		"input2.txt",
#		file3="input3.txt"
#	output:
#		"output.txt",
#		"output2.txt",
#		output3="output3.txt"
#	shell:
		#"echo Hello World"
#		"cat {input.file3} > {output.output3};"
	#	"cat {input[0]} > {output[0]};"
	#	"cat {input[1]} > {output[1]}"
#rule second_rule:
#	input:
#		rule2_input=rules.first_rule.output.output3
#	output:
#		rule2_output="rule2_output.txt"
#	shell:
#		"cat {input.rule2_input} > {output.rule2_output};"
		
#rule bwa_map:
 #   input:
  #      "data/genome.fa",
   #     "data/samples/A.fastq"
   # output:
    #    "mapped_reads/A.bam"
   # shell:
    #    "bwa mem {input} | samtools view -Sb - > {output}"

## A generalized way of mapping the reads
rule bwa_map:
    input:
        "data/genome.fa",
        "data/samples/{sample}.fastq"
    output:
        "mapped_reads/{sample}.bam"
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"

##Step 3: Sorting read alignments
rule samtools_sort:
    input:
        "mapped_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "


        "-O bam {input} > {output}"

##Step 4: Indexing read alignments and visualizing the DAG of jobs
rule samtools_index:
    input:
        "sorted_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam.bai"
    shell:
        "samtools index {input}"
