import os
import random
import shutil
from datetime import datetime
import logging
from pathlib import Path
import sys

def setup_logging():
    """Configure logging for the script"""
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s'
    )

def copy_random_files(source_dir, num_files=1000):
    """
    Copy random files from source directory to a new timestamped directory.
    
    Args:
        source_dir (str): Path to source directory
        num_files (int): Number of files to copy (default: 1000)
    """
    # Setup logging
    setup_logging()
    logger = logging.getLogger(__name__)
    
    try:
        # Convert source_dir to Path object
        source_path = Path(source_dir)
        
        # Verify source directory exists
        if not source_path.is_dir():
            raise ValueError(f"Source directory '{source_dir}' does not exist")
            
        # Get list of all files (not directories) in source directory
        all_files = [f for f in source_path.glob('**/*') if f.is_file()]
        
        # Check if we have enough files
        if len(all_files) < num_files:
            logger.warning(f"Only {len(all_files)} files available in source directory")
            num_files = len(all_files)
        
        # Create timestamp and include source directory basename in output directory name
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        source_basename = source_path.name
        dest_dir = Path(f'{source_basename}_newbatch_{timestamp}')
        
        # Create destination directory
        dest_dir.mkdir(exist_ok=True)
        logger.info(f"Created destination directory: {dest_dir}")
        
        # Randomly select files
        selected_files = random.sample(all_files, num_files)
        
        # Copy files with progress tracking
        for i, file in enumerate(selected_files, 1):
            # Create relative path structure in destination
            rel_path = file.relative_to(source_path)
            dest_path = dest_dir / rel_path
            
            # Create parent directories if they don't exist
            dest_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Copy the file
            shutil.copy2(file, dest_path)
            
            # Log progress every 100 files
            if i % 100 == 0:
                logger.info(f"Copied {i}/{num_files} files")
        
        logger.info(f"Successfully copied {num_files} files to {dest_dir}")
        return str(dest_dir)
        
    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
        raise

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <source_directory>")
        sys.exit(1)
        
    source_dir = sys.argv[1]
    try:
        dest_dir = copy_random_files(source_dir)
        print(f"Files copied successfully to {dest_dir}")
    except Exception as e:
        print(f"Script failed: {str(e)}")
