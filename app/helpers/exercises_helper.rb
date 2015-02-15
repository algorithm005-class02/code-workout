module ExercisesHelper
  def generate_tests(exid,language,base_class,test_method)
      tests=''
      exercise = Exercise.find(exid)
      exercise.coding_question.test_cases.each_with_index do |test_case,i|
      i+=1
      if language=='Ruby'
        tests=tests+"\n\tdef test#{base_class}#{i}"+"\n"
        tests=tests+"\t\tif #{test_method}(#{test_case.input.gsub(";",",")})==#{test_case.expected_output}"+"\n"
        tests=tests+"\t\t\t@@f.write(\"1,,#{i}\\n\") "+"\n"+"\t\telse\n"
        tests=tests+"\t\t\t@@f.write(\"0,#{test_case.negative_feedback.chomp},#{i}\\n\")"+"\n"
        tests=tests+"\t\tend"+"\n"
        tests=tests+"\t\tassert_equal(#{test_method}(#{test_case.input.gsub(";",",")}),#{test_case.expected_output})"+"\n"
        tests=tests+"\tend\n"
      
      elsif language=='Python'
        tests=tests+"\n\tdef test#{i}(self):"+"\n"
        tests=tests+"\t\tif #{base_class}.#{test_method}(#{test_case.input.gsub(";",",")})==#{test_case.expected_output}:"+"\n"
        tests=tests+"\t\t\t#{base_class}Test.f.write(\"1,,#{i}\\n\")"+"\n"+"\t\telse:\n"
        tests=tests+"\t\t\t#{base_class}Test.f.write(\"0,"+test_case.negative_feedback.chomp+','+i.to_s+'\n")'+"\n"
        tests=tests+"\t\tself.assertEqual(#{base_class}.#{test_method}(#{test_case.input.gsub(";",",")}),#{test_case.expected_output})"+"\n"
      
      elsif language=='Java'
        tests=tests+"\n\t@Test"
        tests=tests+"\n\tpublic void test#{test_method}#{i}() {"
        tests=tests+"\n\t\tif ( f.#{test_method}(#{test_case.input.gsub(";",",")}) == #{test_case.expected_output} )"
        tests=tests+"\n\t\t\tfout.println(\"1,,\"+cnt);"
        tests=tests+"\n\t\telse"
        tests=tests+"\n\t\t\tfout.println(\"0,#{test_case.negative_feedback.chomp},\"+cnt);"
        tests=tests+"\n\t\tassertEquals( f.#{test_method}(#{test_case.input.gsub(";",",")}),#{test_case.expected_output});\n}\n"   
      
      end
      
    end
    return tests
  end
  
  
end
