import sys
import operator

# This function will find the unique words in input file and copy in output file
if __name__ == '__main__':
    if (len(sys.argv)) != 6:
        print('Usage: python script_name input_file_train input_file_test output_file_data output_file_libsvm output_file_test')
        exit()
    fin = open(sys.argv[1], 'r')  # training file
    fin1 = open(sys.argv[2], 'r') # testing file
    fout = open(sys.argv[3], 'w') # training file output
    fout1 = open(sys.argv[4],'w') # libsvm outputfile
    fout2 = open(sys.argv[5],'w') # testing file output
    uwords = []
    for line in fin:
        words = line.split()  # will split lines into words which were separated by space
        words = words[2:]  # skip email id and type of email
        for i in range(0, len(words) - 1, 2):
            uwords.append((words[i],0))  # copy all the words from file to uwords list
    uwords = list(set(uwords))
    print len(uwords) #just to print on screen the size of feature space
    dictionary = {}  #dictionary to save words along with their frequency
    dictionary = dict(uwords)
    #print type(dictionary)
    fin.seek(0) # reset the file pointer to beginning
    #making testing output file
    for line in fin1:
        words = line.split()
        type = words[1]
        words = words[2:]
        for i in dictionary.iterkeys():
            dictionary[i] = 0
        for i in range(0,len(words)-1,2):
            if(words[i] in dictionary.keys()):
                key = words[i]
                value = words[i+1]
                dictionary[key] = value
        output_string = ''
        if type == 'spam':
            output_string += '-1'
        else:
            output_string += '1'
        for (k,v) in dictionary.iteritems():
            output_string += ' '+str(v)
        output_string += '\n'
        fout2.write(output_string)
    # making training file output and libsvm output file
    for line in fin:
        words = line.split()
        # resetting Dictionary
        type = words[1]
        words = words[2:]
        for i in dictionary.iterkeys():
            dictionary[i] = 0
            
        for i in range(0, len(words)-1, 2):
            key = words[i]
            value = words[i+1]
            dictionary[key] = value
        output_string = ''
        output_string1 = ''
        if type == 'spam':
            output_string += '-1'
            output_string1 += '-1'
        else:
            output_string += '1'
            output_string1 += '1'
        for (k,v) in dictionary.iteritems():
            output_string += ' '+str(k)+':'+str(v)
            output_string1 += ' '+str(v)
        output_string += '\n'
        output_string1 += '\n'
        fout.write(output_string)
        fout1.write(output_string1)
    fin.close()
    fout.close()
