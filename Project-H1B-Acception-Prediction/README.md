# H-1B Visa Petitions 2011-2016 

- Overview: This project aims to utilize the 'H-1B Visa Petitions 2011-2016' dataset to review the general trends of international recruiting and categorize the job titles into different domains to compare hiring interests of different industries. More details can be found in '0_Project-Description' file.

- Steps:
  - EDA + Data Cleaning 
    - Missing values: case by case 
    - Classifications of the 'y': only devide a claim to either 'certified' or 'denied'
    - Deal with 'x': case by case (categorical & numeric)
      - sentence transformer method
      - cluster 
      - get dummy variable
  - Models
    - Train/Test split
    - SMOTE method to balance data
    - Decision Tree, Random Forest, Gradient Boosting, Logistic Regression, Naïve Bayesian, Stochastic Gradient Descent, and Perceptron
    - Parameter tuning: GridSearchCV and RandomizedSearchCV
  - Model Result & Evaluations
    - Best Performing models: Tree-based methods: Decision Tree, Random Forest, and Gradient Boosting
    - Random forest pro and cons
      - Pro: good for high dimensional data and pretty robust to outliers and non-linear data, minimizes the balancing error rates, has a low bias errors (the predicted values won’t deviate from the actual values that much) 
      - Con: for very large data sets, the size of the trees can take up a lot of memory
    - Evaluation metrics: 
      - f-score, accuracy and auc score
      - Receiver Operator Characteristic (ROC) curve and The Area Under the Curve (AUC): the higher the AUC, the better the performance of the model at distinguishing between the positive and negative classes.
    - Underfitting problem for gradient boosting
    
- Key findings:
  - The most important features for H1B Case Status is Prevailing Wage；
  - Infosys Limited submitted the greatest number of H1-B visa applications;
  - Programmer Analyst is the most common Job Titles applied for by the high applicant employers;
  - Occupations that are in IT field with full-time position, relative high wages are more likely to qualify for an H-1 B visa.
