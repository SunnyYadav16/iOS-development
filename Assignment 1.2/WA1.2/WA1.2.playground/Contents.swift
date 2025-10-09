import Foundation

// MARK: - Part 1: Protocol and Struct Definition

/// Protocol that defines display and grade update requirements
protocol StudentInfoProtocol {
    //Define the protocol here
    var displayInfo: String { get }
    mutating func updateGrade(subject: String, grade: Double)
}

/// Student struct conforming to Displayable protocol
struct Student: StudentInfoProtocol{
    //Add the properties
    let name: String
    let studentID: Int
    var grades = [String: Double]()
    var year: Int
    
    init(name: String, studentID: Int, grades: [String: Double], year: Int) {
        self.name = name
        self.studentID = studentID
        self.grades = grades
        
        if year >= 1 && year <= 4 {
            self.year = year
        } else {
            print("Years must be between 1 and 4. Setting 1 by default.")
            self.year = 1
        }
    }
    
    /// Computed property that returns formatted student information
    var displayInfo: String {
        /* Write the logic to compute the property, the formatted string should look like:
         
         Student: Alice Johnson (ID: 1001, Year: 2)
         Subjects: Math: 95.0, Science: 88.0, English: 92.0
         Average: 91.67

         */
        let average = calculateAverage()
        
        let sortedGrades = grades.sorted { $0.key < $1.key }
        let sortedGradesString = sortedGrades.map { "\($0.key): \($0.value)" }
        
        var info = """
            Student: \(name) (ID: \(studentID), Year: \(year))
            Subjects: \(sortedGradesString)
            Average: \(String(format: "%.2f", average))
            """
        return info
    }
    
    /// Updates or adds a grade for a specific subject
    mutating func updateGrade(subject: String, grade: Double) {
        //Should be able update grade for the student
        grades[subject] = grade
    }
    
    /// Write any helper functions needed...
    func calculateAverage() -> Double {
        if grades.isEmpty { return 0.0 }
        let sum = grades.values.reduce(0, +)
        return sum / Double(grades.count)
    }
    
    // Helper function to get letter grades from numerical grades
    func getLetterGrade() -> String {
            let average = calculateAverage()
            switch average {
            case 90...100:
                return "A"
            case 80..<90:
                return "B"
            case 70..<80:
                return "C"
            case 60..<70:
                return "D"
            default:
                return "F"
            }
        }
}

// MARK: - Part 2: Student Management Class

class StudentManager {
    var students: [Student]
    
    /// Initialize with an array of students
    init(students: [Student] = []) {
        self.students = students
    }
    
    /// Add a new student to the array
    func addStudent(_ student: Student) {
        //write logic
        students.append(student)
        print("New student \(student.name) added successfully!")
    }
    
    /// Display all students
    func displayAllStudents() {
        print("\n=== All Students ===")
        
        //Write the needed logic
        for student in students {
            print(student.displayInfo)
            print("")
        }
    }
    
    /// Find students by year
    func findStudentsByYear(_ year: Int) -> [Student] {
        var foundStudents: [Student] = []
        let yearRange = 1...4
        
        if !yearRange.contains(year) {
            print("Invalid year. Year must be between 1 and 4.")
            return []
        }
        
        //Write the needed logic
        for student in students {
            if student.year == year {
                foundStudents.append(student)
            }
        }
        
        return foundStudents
    }
    
    /// Sort students alphabetically by name using a closure
    func sortStudentsByName() -> [Student] {
        //Write the needed logic
        return students.sorted(by: {$0.name < $1.name})
    }
    
    /// Sort students by average grade (highest to lowest) using a closure
    func sortStudentsByAverage() -> [Student] {
        // Write the needed logic
        return students.sorted(by: {$0.calculateAverage() > $1.calculateAverage()})
    }
    
    /// Get top N performing students
    func getTopPerformers(count: Int) -> [Student] {
        //Write the needed logic, you can google for needed library functions here
        let sortedStudents = sortStudentsByAverage()
        return Array(sortedStudents.prefix(count))
    }
    
    /// Get all students (for external access)
    func getAllStudents() -> [Student] {
        return students
    }
    
    // MARK: - Write Bonus Methods if needed
    
    func listStudentsByYear() {
        print("\n=== BONUS: Students by Year ===")
        for year in 1...4 {
            let yearStudents = findStudentsByYear(year)
            if !yearStudents.isEmpty {
                print("\nYear \(year) Students:")
                for student in yearStudents {
                    print("  - \(student.name) (Average: \(String(format: "%.2f", student.calculateAverage())), Grade: \(student.getLetterGrade()))")
                }
            }
        }
    }
    
    func updateStudentGrades(studentID: Int, subject: String, newGrade: Double) -> Bool {
        print("\n=== BONUS: Updating Grade Example ===")
        if let studentIndex = students.firstIndex(where: { $0.studentID == studentID }) {
            print("Before Update:")
            print("Student: \(students[studentIndex].name) (ID: \(students[studentIndex].studentID), Year: \(students[studentIndex].year))")
            print("Subjects: \(students[studentIndex].grades)")
            print("Average: \(String(format: "%.2f", students[studentIndex].calculateAverage()))")
            
            students[studentIndex].updateGrade(subject: subject, grade: newGrade)
            
            print()
            print("After Update:")
            print("Student: \(students[studentIndex].name) (ID: \(students[studentIndex].studentID), Year: \(students[studentIndex].year))")
            print("Subjects: \(students[studentIndex].grades)")
            print("Average: \(String(format: "%.2f", students[studentIndex].calculateAverage()))")
            return true
        }
        print("Student with ID: \(studentID) not found.")
        return false
    }
    
}

// MARK: - Part 3: Implementation and Testing

/// Function to create sample students
func createSampleStudents() -> [Student] {
    var students: [Student] = []
    students = [
        Student(
            name: "Alice Johnson",
            studentID: 1001,
            grades: ["Math": 95.0, "Science": 88.0, "English": 92.0],
            year: 2
        ), Student(
            name: "Bob Smith",
            studentID: 1002,
            grades: ["Math": 78.0, "Science": 85.0, "English": 80.0],
            year: 1
        ), Student(
            name: "Charlie Brown",
            studentID: 1003,
            grades: ["Math": 92.0, "Science": 96.0, "English": 89.0, "History": 94.0],
            year: 3
        ), Student(
            name: "Diana Prince",
            studentID: 1004,
            grades: ["Math": 87.0, "Science": 91.0, "English": 95.0],
            year: 2
        ), Student(
            name: "Edward Wilson",
            studentID: 1005,
            grades: ["Math": 76.0, "Science": 82.0, "English": 78.0, "History": 80.0],
            year: 4
        )
    ]
    
    return students
}

/// Main execution function
func runStudentManagementSystem() {
    print("🎓 Student Management System Demo")
    print("================================")
    
    // Create sample data
    let sampleStudents = createSampleStudents()
    let manager = StudentManager(students: sampleStudents)
    
    // Display all students
    manager.displayAllStudents()
    
    //MARK: Add a new student example
    print("=== Adding New Student ===")
    var newStudent = Student(
        name: "Frank Miller",
        studentID: 1006,
        grades: ["Math": 90.0, "Science": 93.0, "English": 88.0],
        year: 1
    )
    manager.addStudent(newStudent)
    
    
    //MARK: Find students by year example
    print("\n=== Students in Year 2 ===")
    let year2Students = manager.findStudentsByYear(2)
    for student in year2Students {
        print(student.displayInfo)
        print("")
    }
    
    //MARK: Show students sorted by name
    print("=== Students Sorted by Name ===")
    //Write remaining logic here...
    let nameSortedStudents = manager.sortStudentsByName()
    for student in nameSortedStudents {
        print("\(student.name) - Average: \(String(format: "%.2f", student.calculateAverage()))")
    }
    
    //MARK: Show students sorted by average grade
    print("\n=== Students Sorted by Average Grade ===")
    //Write remaining logic here...
    let gradeSortedStudents = manager.sortStudentsByAverage()
    for student in gradeSortedStudents {
        print("\(student.name) - Average: \(String(format: "%.2f", student.calculateAverage()))")
    }

    //MARK: Display top 3 performers
    print("\n=== Top 3 Performers ===")
    //Write remaining logic here...
    let topPerformers = manager.getTopPerformers(count: 3)
    for (index, student) in topPerformers.enumerated() {
        print("\(index + 1). \(student.name) - Average: \(String(format: "%.2f", student.calculateAverage()))")
    }
    
    // Bonus: List students by Year
    manager.listStudentsByYear()
    
    // Bonus: Update students grades
    manager.updateStudentGrades(studentID: 1001, subject: "Physics", newGrade: 97)
    
    // Bonus: Showcase letter grades for all students
    print("\n=== BONUS: Students with Letter Grades ===")
    for student in manager.sortStudentsByAverage() {
        print("\(student.name) - Average: \(String(format: "%.2f", student.calculateAverage())) - Grade: \(student.getLetterGrade())")
    }
}

//MARK: Run the demonstration
runStudentManagementSystem()
