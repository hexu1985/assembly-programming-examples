if:
    <condition to evaluate>
    jxx else ; jump to the else part if the condition is false

    <code to implement the “then” statements>
    jmp end ;jump to the end

else:
    < code to implement the “else” statements>

end:



# if (eax < ebx) || (eax == ecx) then

if:
    cmpl %eax, %ebx
    jle else
    cmpl %eax, %ecx
    jne else

then:
    < then logic code>
    jmp end

else:
    < else logic code >

end:
