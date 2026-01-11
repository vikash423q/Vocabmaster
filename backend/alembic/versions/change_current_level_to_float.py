"""change_current_level_to_float

Revision ID: change_level_float
Revises: 6650655e0ccc
Create Date: 2026-01-11 03:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'change_level_float'
down_revision: Union[str, None] = '6650655e0ccc'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Drop the old enum-based current_level column
    op.drop_column('users', 'current_level')
    
    # Add new float-based current_level column (nullable, default null)
    op.add_column('users', sa.Column('current_level', sa.Numeric(3, 1), nullable=True))
    
    # Drop the UserLevel enum type (if it exists and is not used elsewhere)
    # Note: Only drop if not used by other columns
    op.execute("DROP TYPE IF EXISTS userlevel")


def downgrade() -> None:
    # Remove float column
    op.drop_column('users', 'current_level')
    
    # Recreate enum type
    op.execute("""
        CREATE TYPE userlevel AS ENUM ('beginner', 'intermediate', 'advanced')
    """)
    
    # Add back enum column with default
    op.add_column('users', sa.Column('current_level', sa.Enum('beginner', 'intermediate', 'advanced', name='userlevel'), nullable=False, server_default='beginner'))
