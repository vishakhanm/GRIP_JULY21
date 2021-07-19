SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `sno` int(3) NOT NULL,
  `sender` int(3) NOT NULL,
  `receiver` int(3) NOT NULL,
  `balance` int(8) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--



-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(3) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(30) NOT NULL,
  `balance` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `balance`) VALUES
(1, 'Akshay Mehta', 'akshaymehta@yahoo.com', 3000),
(2, 'Vijay Salaskar', 'vijaysalaskar@gmail.com', 5000),
(3, 'Priya Datta', 'priyadete@gmail.com', 6000),
(4, 'Priyanshu Sharma', 'priyanshusharma15@gmail.com', 5600),
(5, 'Archana Koli', 'archanakoli@gmail.com', 9000),
(6, 'akshay kumar', 'akshaykumar23@outlook.com', 3000),
(7, 'riya patil', 'riya1007@gmail.com', 6000),
(8, 'darshit malhotra', 'darshit2001@outlook.com', 5600),
(9, 'priyanka chopra', 'priyanka12@gmail.com', 10000),
(10, 'ved shah', 'vedshah20@gmail.com', 5000),
(11, 'chaitali desai', 'chaitali32@yahoo.com', 7000),
(12, 'raj yadav', 'rajyadav@outlook.com', 4000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `sno` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

ALTER TABLE `transaction`
ADD FOREIGN KEY (sender) REFERENCES users(id);

ALTER TABLE `transaction`
ADD FOREIGN KEY (receiver) REFERENCES users(id);
