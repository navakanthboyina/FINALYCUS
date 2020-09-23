class EMI_CALCULATOR(object):

      Loan_amount = None 
      Month_Payment = None
      Interest_rate = None 
      Payment_period = None

      def get_loan_amount(self):
          self.Loan_amount = int(input("Enter The Loan amount(in rupees) :"))
          pass

      def get_interest_rate(self):
          self.Interest_rate = int(input("Enter The Interest rate(in percentage(%)) : "))
          pass

      def get_payment_period(self):
          self.Payment_period = int(input("Enter The Payment period (in month): "))
          pass

      def calc_interest_rate(self):
          self.get_interest_rate()

          if self.Interest_rate > 1:
             self.Interest_rate = (self.Interest_rate /100.0) 
         
          else:
             print ("You have not entered The interest rate correctly ,please try again ")
          pass

      def calc_emi(self):
      # To calculate the EMI"          

          try:

            self.get_loan_amount()
            self.get_payment_period()
            self.calc_interest_rate()
          
          except NameError:
                 print ("You have not entered Loan amount (OR) payment period (OR) interest rate  correctly,Please enter and try again. ")
         
          try:
            self.Month_Payment = (self.Loan_amount*pow((self.Interest_rate/12)+1,
                                 (self.Payment_period))*self.Interest_rate/12)/(pow(self.Interest_rate/12+1,
                                 (self.Payment_period)) - 1)

          except ZeroDivisionError: 
                        print ("ERROR!! ZERO DIVISION ERROR , Please enter The Interest rate correctly and Try again.")

          else:
             print ("Monthly Payment is : %r"%self.Month_Payment)
          pass


if __name__ == '__main__':
                              
   Init = EMI_CALCULATOR()
                  
   Init.calc_emi() #to calculate EMI
