[translated]
module main

enum Fuse_readdir_flags {
		fuse_readdir_plus = 1 << 0}

enum Fuse_fill_dir_t {
		fuse_fill_dir_plus = 1 << 1}

type Fuse_fill_dir_t = fn (voidptr, &i8, &Stat, Off_t, Enum fuse_fill_dir_flags) int
struct Fuse_config { 
	set_gid int
	gid u32
	set_uid int
	uid u32
	set_mode int
	umask u32
	entry_timeout f64
	negative_timeout f64
	attr_timeout f64
	intr int
	intr_signal int
	remember int
	hard_remove int
	use_ino int
	readdir_ino int
	direct_io int
	kernel_cache int
	auto_cache int
	ac_attr_timeout_set int
	ac_attr_timeout f64
	nullpath_ok int
	show_help int
	modules &i8
	debug int
}
struct Fuse_operations { 
	getattr fn (&i8, &Stat, &Fuse_file_info) int
	readlink fn (&i8, &i8, usize) int
	mknod fn (&i8, Mode_t, Dev_t) int
	mkdir fn (&i8, Mode_t) int
	unlink fn (&i8) int
	rmdir fn (&i8) int
	symlink fn (&i8, &i8) int
	rename fn (&i8, &i8, u32) int
	link fn (&i8, &i8) int
	chmod fn (&i8, Mode_t, &Fuse_file_info) int
	chown fn (&i8, Uid_t, Gid_t, &Fuse_file_info) int
	truncate fn (&i8, Off_t, &Fuse_file_info) int
	open fn (&i8, &Fuse_file_info) int
	read fn (&i8, &i8, usize, Off_t, &Fuse_file_info) int
	write fn (&i8, &i8, usize, Off_t, &Fuse_file_info) int
	statfs fn (&i8, &Statvfs) int
	flush fn (&i8, &Fuse_file_info) int
	release fn (&i8, &Fuse_file_info) int
	fsync fn (&i8, int, &Fuse_file_info) int
	setxattr fn (&i8, &i8, &i8, usize, int) int
	getxattr fn (&i8, &i8, &i8, usize) int
	listxattr fn (&i8, &i8, usize) int
	removexattr fn (&i8, &i8) int
	opendir fn (&i8, &Fuse_file_info) int
	readdir fn (&i8, voidptr, Fuse_fill_dir_t, Off_t, &Fuse_file_info, Enum fuse_readdir_flags) int
	releasedir fn (&i8, &Fuse_file_info) int
	fsyncdir fn (&i8, int, &Fuse_file_info) int
	init fn (&Fuse_conn_info, &Fuse_config) voidptr
	destroy fn (voidptr)
	access fn (&i8, int) int
	create fn (&i8, Mode_t, &Fuse_file_info) int
	// lock fn (&i8, &Fuse_file_info, int, &Flock) int
	utimens fn (&i8, &Timespec, &Fuse_file_info) int
	bmap fn (&i8, usize, &u64) int
	ioctl fn (&i8, int, voidptr, &Fuse_file_info, u32, voidptr) int
	poll fn (&i8, &Fuse_file_info, &Fuse_pollhandle, &u32) int
	write_buf fn (&i8, &Fuse_bufvec, Off_t, &Fuse_file_info) int
	read_buf fn (&i8, &&Fuse_bufvec, usize, Off_t, &Fuse_file_info) int
	flock fn (&i8, &Fuse_file_info, int) int
	fallocate fn (&i8, int, Off_t, Off_t, &Fuse_file_info) int
	copy_file_range fn (&i8, &Fuse_file_info, Off_t, &i8, &Fuse_file_info, Off_t, usize, int) Ssize_t
	lseek fn (&i8, Off_t, int, &Fuse_file_info) Off_t
}
struct Fuse_context { 
	fuse &Fuse
	uid Uid_t
	gid Gid_t
	pid Pid_t
	private_data voidptr
	umask Mode_t
}
struct Fuse_fs { 
}
type Fuse_module_factory_t = fn (&Fuse_args, &&Fuse_fs) &Fuse_fs
fn access(__name &i8, __type int) int

fn pread(__fd int, __buf voidptr, __nbytes usize, __offset off_t) Ssize_t

fn pwrite(__fd int, __buf voidptr, __n usize, __offset off_t) Ssize_t

fn chown(__file &i8, __owner uid_t, __group gid_t) int

fn lchown(__file &i8, __owner uid_t, __group gid_t) int

fn link(__from &i8, __to &i8) int

fn symlink(__from &i8, __to &i8) int

fn readlink(__path Char *restrict, __buf Char *restrict, __len usize) Ssize_t

fn unlink(__name &i8) int

fn rmdir(__path &i8) int

fn fsync(__fd int) int

fn sync() 

fn truncate(__file &i8, __length off_t) int

fn copy_file_range(__infd int, __pinoff &off64_t, __outfd int, __poutoff &off64_t, __length usize, __flags u32) Ssize_t

type DIR = Dirstream
fn opendir(__name &i8) &DIR

fn closedir(__dirp &DIR) int

fn readdir(__dirp &DIR) &Dirent

enum __itimer_which {
	itimer_real = 0	itimer_virtual = 1	itimer_prof = 2}

struct Itimer_which_t { 
	it_interval Timeval
	it_value Timeval
}
fn utimes(__file &i8, __tvp &Timeval) int

fn mknod_wrapper(dirfd int, path &i8, link &i8, mode int, rdev Dev_t) int {
	res := 0
	if ((((mode)) & 61440) == (32768)) {
		res = openat(dirfd, path, 64 | 128 | 1, mode)
		if res >= 0 {
		res = C.close(res)
		}
	}
	else if ((((mode)) & 61440) == (16384)) {
		res = mkdirat(dirfd, path, mode)
	}
	else if ((((mode)) & 61440) == (40960)) && link != (voidptr(0)) {
		res = symlinkat(link, dirfd, path)
	}
	else if ((((mode)) & 61440) == (4096)) {
		res = mkfifoat(dirfd, path, mode)
	}
	else {
		res = mknodat(dirfd, path, mode, rdev)
	}
	return res
}

/*!*/[weak] __global ( fill_dir_plus  = int (0)
)

fn xmp_init(conn &Fuse_conn_info, cfg &Fuse_config) voidptr {
	void(conn)
	cfg.use_ino = 1
	cfg.entry_timeout = 0
	cfg.attr_timeout = 0
	cfg.negative_timeout = 0
	return (voidptr(0))
}

fn xmp_getattr(path &i8, stbuf &Stat, fi &Fuse_file_info) int {
	void(fi)
	res := 0
	res = lstat(path, stbuf)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_access(path &i8, mask int) int {
	res := 0
	res = access(path, mask)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_readlink(path &i8, buf &i8, size usize) int {
	res := 0
	res = readlink(path, buf, size - 1)
	if res == -1 {
	return -(*__errno_location())
	}
	buf [res]  = ` `
	return 0
}

fn xmp_readdir(path &i8, buf voidptr, filler Fuse_fill_dir_t, offset Off_t, fi &Fuse_file_info, flags Enum fuse_readdir_flags) int {
	dp := &DIR(0)
	de := &Dirent(0)
	void(offset)
	void(fi)
	void(flags)
	dp = opendir(path)
	if dp == (voidptr(0)) {
	return -(*__errno_location())
	}
	for (de = readdir(dp)) != (voidptr(0)) {
		st := Stat{}
		C.memset(&st, 0, sizeof(st))
		st.st_ino = de.d_ino
		st.st_mode = de.d_type << 12
		if filler(buf, de.d_name, &st, 0, fill_dir_plus) {
		break
		
		}
	}
	closedir(dp)
	return 0
}

fn xmp_mknod(path &i8, mode Mode_t, rdev Dev_t) int {
	res := 0
	res = mknod_wrapper(-100, path, (voidptr(0)), mode, rdev)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_mkdir(path &i8, mode Mode_t) int {
	res := 0
	res = mkdir(path, mode)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_unlink(path &i8) int {
	res := 0
	res = unlink(path)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_rmdir(path &i8) int {
	res := 0
	res = rmdir(path)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_symlink(from &i8, to &i8) int {
	res := 0
	res = symlink(from, to)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_rename(from &i8, to &i8, flags u32) int {
	res := 0
	if flags {
	return -22
	}
	res = C.rename(from, to)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_link(from &i8, to &i8) int {
	res := 0
	res = link(from, to)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_chmod(path &i8, mode Mode_t, fi &Fuse_file_info) int {
	void(fi)
	res := 0
	res = chmod(path, mode)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_chown(path &i8, uid Uid_t, gid Gid_t, fi &Fuse_file_info) int {
	void(fi)
	res := 0
	res = lchown(path, uid, gid)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_truncate(path &i8, size Off_t, fi &Fuse_file_info) int {
	res := 0
	if fi != (voidptr(0)) {
	res = C.ftruncate(fi.fh, size)
	}
	else { // 3
	res = truncate(path, size)
}
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_create(path &i8, mode Mode_t, fi &Fuse_file_info) int {
	res := 0
	res = C.open(path, fi.flags, mode)
	if res == -1 {
	return -(*__errno_location())
	}
	fi.fh = res
	return 0
}

fn xmp_open(path &i8, fi &Fuse_file_info) int {
	res := 0
	res = C.open(path, fi.flags)
	if res == -1 {
	return -(*__errno_location())
	}
	fi.fh = res
	return 0
}

fn xmp_read(path &i8, buf &i8, size usize, offset Off_t, fi &Fuse_file_info) int {
	fd := 0
	res := 0
	if fi == (voidptr(0)) {
	fd = C.open(path, 0)
	}
	else { // 3
	fd = fi.fh
}
	if fd == -1 {
	return -(*__errno_location())
	}
	res = pread(fd, buf, size, offset)
	if res == -1 {
	res = -(*__errno_location())
	}
	if fi == (voidptr(0)) {
	C.close(fd)
	}
	return res
}

fn xmp_write(path &i8, buf &i8, size usize, offset Off_t, fi &Fuse_file_info) int {
	fd := 0
	res := 0
	void(fi)
	if fi == (voidptr(0)) {
	fd = C.open(path, 1)
	}
	else { // 3
	fd = fi.fh
}
	if fd == -1 {
	return -(*__errno_location())
	}
	res = pwrite(fd, buf, size, offset)
	if res == -1 {
	res = -(*__errno_location())
	}
	if fi == (voidptr(0)) {
	C.close(fd)
	}
	return res
}

fn xmp_statfs(path &i8, stbuf &Statvfs) int {
	res := 0
	res = statvfs(path, stbuf)
	if res == -1 {
	return -(*__errno_location())
	}
	return 0
}

fn xmp_release(path &i8, fi &Fuse_file_info) int {
	void(path)
	C.close(fi.fh)
	return 0
}

fn xmp_fsync(path &i8, isdatasync int, fi &Fuse_file_info) int {
	void(path)
	void(isdatasync)
	void(fi)
	return 0
}

fn xmp_lseek(path &i8, off Off_t, whence int, fi &Fuse_file_info) Off_t {
	fd := 0
	res := Off_t{}
	if fi == (voidptr(0)) {
	fd = C.open(path, 0)
	}
	else { // 3
	fd = fi.fh
}
	if fd == -1 {
	return -(*__errno_location())
	}
	res = C.lseek(fd, off, whence)
	if res == -1 {
	res = -(*__errno_location())
	}
	if fi == (voidptr(0)) {
	C.close(fd)
	}
	return res
}

[export:'xmp_oper']
const (
xmp_oper   = Fuse_operations {
xmp_getattr, xmp_readlink, xmp_mknod, xmp_mkdir, xmp_unlink, xmp_rmdir, xmp_symlink, xmp_rename, xmp_link, xmp_chmod, xmp_chown, xmp_truncate, xmp_open, xmp_read, xmp_write, xmp_statfs, 0/*IMPLICIT*/xmp_release, xmp_fsync, 0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/xmp_readdir, 0/*IMPLICIT*/0/*IMPLICIT*/xmp_init, 0/*IMPLICIT*/xmp_access, xmp_create, 0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/0/*IMPLICIT*/xmp_lseek}

)

fn main()  {
	
	i := 0
	new_argc := 0
	
	new_argv := [10]&i8{}
	umask(0)
	for i = 0 , 0
	new_argc = i = 0 ; (i < argc) && (new_argc < max_args) ; i ++ {
		if !C.strcmp(os.argv [i] , c'--plus') {
			fill_dir_plus = Fuse_fill_dir_t.fuse_fill_dir_plus
		}
		else {
			new_argv [new_argc ++]  = os.argv [i] 
		}
	}
	return 
}

