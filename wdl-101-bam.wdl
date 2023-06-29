version 1.0
workflow SamtoolsMetrics {
  input {
    File inputBam 
  }
  call Samtools_task {
    input: 
       bam_name = inputBam
  }
  output {
       File output_name = Samtools_task.output_count
  }
}

task Samtools_task  {
  input {
     File bam_name
  }
  command <<<
     samtools index ~{bam_name}
     samtools idxstats ~{bam_name} > count.txt
  >>>
  output {
     File output_count = "count.txt"
  }
  runtime {
    docker: 'ekiernan/wdl-101:v1'
  }
}
