import Vector::*;


function Bit#(32) multiplexer32(Bit#(1) sel, Bit#(32) a, Bit#(32) b);

return (sel == 0)?a:b; 

endfunction

function Bit#(32) logicalBarrelShifter(Bit#(32) operand, Bit#(5) shamt);

    Bit#(32) shifted=0;
    for(Integer i=0;i<5;i=i+1)
    begin
        Integer pow=1;
        for(Integer k=0;k<i;k=k+1)
        begin
            pow = pow * 2;
        end 		
        for(Integer j=0;j< (32-pow) ;j=j+1)
        begin
            shifted[j]=operand[j+pow];	
        end
    operand = multiplexer32(shamt[i],operand,shifted);
    shifted=0;
    end
return operand;
endfunction

function Bit#(32) arithmeticBarrelShifter(Bit#(32) operand, Bit#(5) shamt);
    Bit#(32) shifted=0;
    Bit#(1) left=operand[31];
    for(Integer i=0;i<5;i=i+1) 
    begin
        Integer pow=1;
        for(Integer k=0;k<i;k=k+1) 
        begin
            pow = pow * 2;
        end
        for(Integer j=0;j< (32-pow) ;j=j+1)
        begin
            shifted[j]=operand[j+pow];
        end
        for(Integer j=0; j<pow ;j=j+1) 
        begin
            shifted[31-j]=left;
        end
    operand = multiplexer32(shamt[i],operand,shifted);
    shifted=0;

    end

return {operand};
endfunction

function Bit#(32) logicalLeftRightBarrelShifter(Bit#(1) shiftLeft, Bit#(32) operand, Bit#(5) shamt);
	Bit#(32) rev=0;
	Bit#(32) to_op=0;	
		for(Integer j=0;j<32;j=j+1)
		begin
			rev[j]=operand[31-j];
		end
		to_op=multiplexer32(shiftLeft,operand,rev);
		Bit#(32) a=logicalBarrelShifter(to_op,shamt);
		Bit#(32) ra;
		for(Integer i=0;i<32;i=i+1)
		begin
			ra[i]=a[31-i];
		end
		Bit#(32) ans=multiplexer32(shiftLeft,a,ra);
	return ans;
endfunction

