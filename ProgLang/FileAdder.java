import java.util;

public class FileAdder {
	public static int adder(String[] elements) {
		int total = 0;
		for (String s : elements) {
			try {
				total += Integer.parseInt(s);
			} catch(NumberFormatException e) {
				System.out.println("Ignoring bad input: " + s);
			}
		} 
		return total;
	}

	public static String[] readFile() {
		Scanner fileNameReader = new Scanner(System.in);
		System.out.println("Enter a file name: ");
		String fileName = fileNameReader.nextLine();
		List<String> filearray = new ArrayList<String>();
		try {
			Scanner fileReader = new Scanner(new File(fileName));
			while ( fileReader.hasNextLine() ) {
				filearray.add(fileReader.nextLine());
			} 
		} catch(FileNotFoundException e) {
			System.out.println("Error -- File" + fileName + "not found");
			break;
		}
		String[] fileContents = new String[filearray.size()];
		filearray.toArray( fileContents );
		return fileContents;
	}

	public static void main(String[] args) {
		String[] fileContents = FileAdder.readFile();
		int total = FileAdder.adder(fileContents);
		System.out.println("The total is " + total);
	}
}
